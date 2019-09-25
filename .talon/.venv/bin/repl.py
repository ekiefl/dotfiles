import atexit
import json
import os
import readline
import socket

histfile = os.path.expanduser('~/.talon/.sys/.repl_history')
if os.path.exists(histfile):
    readline.read_history_file(histfile)
    readline.set_history_length(1000)

atexit.register(readline.write_history_file, histfile)

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
try:
    s.connect(os.path.expanduser('~/.talon/.sys/repl.sock'))
except ConnectionRefusedError:
    print('Could not open repl. Is Talon running?')
    exit()
sin = s.makefile('r', buffering=1, encoding='utf8')

def send(cmd, **m):
    m['cmd'] = cmd
    s.send((json.dumps(m) + '\n').encode('utf8'))

def recv():
    return json.loads(sin.readline())

def complete(text, state):
    if not text:
        readline.insert_text('    ')
        return None
    send('complete', text=text, state=state)
    text = recv()['text']
    return text

readline.set_completer(complete)

try:
    while True:
        m = recv()
        cmd = m['cmd']
        if cmd == 'prompt':
            prompt = m['prompt']
            try:
                line = input(prompt)
                if 'keychain.add(' in line:
                    readline.remove_history_item(readline.get_current_history_length()-1)
                send('input', text=line)
            except KeyboardInterrupt:
                send('reset')
            except EOFError:
                try: s.shutdown(socket.SHUT_RDWR)
                except Exception: pass
                break
        elif cmd == 'print':
            print(m['text'].rstrip('\n'))
        elif cmd == 'exit':
            break
    print()
except BrokenPipeError:
    print()
    print('[Talon quit]')
