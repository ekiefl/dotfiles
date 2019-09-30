from talon.voice import Word, Key, Rep, Str, press
from .user_context import Context
from .mouse import initial_pos_click
from .mouse import final_pos_click
from .mouse import advanced_click
from .std import punctuation
from .std import lower_upper_digits
import time
ctx = Context('vim', bundle='com.googlecode.iterm2', func=lambda app, win: 'vim' in win.title)

vimmap = {}

# Teleport commands and here to here commands allow jumping across windows, but the latency cost
# for getting a window ID and moving the cursor to that window ID is about ~0.15s, which is not worth
# it in most cases. I would like to implement a solution where I can turn on and off this flag, but
# for now it is statically defined in this file.
DISABLE_WINDOW_SWAPPING = True

LEADER = 'space'

# hacky ways for repeat commands that take numbers as variables (there is another one of these in std)
vimmap.update({'%d buff' % k: [Key('escape')] + [Key('shift-right'), lambda m: time.sleep(0.1)]*k for k in range(2, 10)})
vimmap.update({'%d ruff' % k: [Key('escape')] + [Key('shift-left'), lambda m: time.sleep(0.1)]*k for k in range(2, 10)})
vimmap.update({'%d box' % k: ['x']*k for k in range(2, 10)})
vimmap.update({'%d undo' % k: ['u']*k for k in range(2, 10)})
vimmap.update({'%d redo' % k: [Key('ctrl-r')]*k for k in range(2, 10)})

# I share this with bash.py (I have vim-style bash -- see ~/.inputrc)
common_to_bash = {
    "gif"       : "F",
    "til"       : "t",
    "lit"       : "T",
    "bane"      : "ge",
    "ship bane" : "gE",
    "die line"  : "dd",
}; vimmap.update(common_to_bash)

cursor_movement = {
    # line search
    'flexy' : '0',

    # line movement
    'fly' : 'G',

    # variations of slap
    'slapper' : Key('escape shift-a enter'),
    'coder' : Key('escape shift-a : enter tab'),
    'slender' : Key('escape shift-a enter tab'),

    'coker' : [Key('escape shift-a'), ' {}', Key('left enter')], # no tab is necessary with auto pairs plug
}; vimmap.update(cursor_movement)

viewport = {
    "more" : Key("esc shift-j"),
    "less" : Key("esc shift-k"),
    "lesser" : Key("esc shift-u"),
    "mortar" : Key("esc shift-d"),
}; vimmap.update(viewport)

window_handler = {
    'buff'                  : Key('esc shift-right'),
    'ruff'                  : Key('esc shift-left'),
    'north'                 : Key('ctrl-k'),
    'south'                 : Key('ctrl-j'),
    'east'                  : Key('ctrl-l'),
    'west'                  : Key('ctrl-h'),
    'close (buff | buffer)' : Key('%s c' % LEADER),
    # sometimes saving doesn't work on barhal so small sleep command is added
    'write it'              : [Key('escape'), lambda m: time.sleep(0.25), Key('%s w' % LEADER)],
    'run it'                : [Key('escape'), lambda m: time.sleep(0.25), Key('%s w' % LEADER), lambda m: time.sleep(0.5), Key('cmd-l up enter')],
    'run same'                : [Key('escape'), lambda m: time.sleep(0.25), Key('%s w' % LEADER), lambda m: time.sleep(0.5), Key('ctrl-z up up enter')],

    # terminal navigation
    'torque': Key('esc %s b' % LEADER),
    'court': Key('ctrl-v'),

    'quit it'               : [Key('esc'), Key('%s' % LEADER), "q"],
    'force quit it'         : [Key('esc'), Key('%s' % LEADER), "fq"],
    'force quit all confirm'        : [Key('esc'), ':qa!', Key('enter')],
}; vimmap.update(window_handler)

plugins = {
    # tagbar, nerdtree
   '(tack board | tag-bar)' :  [Key("escape %s" % LEADER), "t"],
   'nerd'                   :  [Key("escape %s" % LEADER), "o"],

    # Tabularize
    'tabularize'            :  [":Tab", Key("space"), "/"],

    # jedi
    'show me'               :  lambda m: press('ctrl-space', wait=16000), # does not work in iterm :(
    'soy'                   :  Key('ctrl-y'),

    # git
    'blame': [Key('esc'), ':Gblame', Key('enter')],

    # surround
    'surround list'         : ['S)', lambda m: time.sleep(0.3), 'ilist', Key('escape')],
    'surround dickt'        : ['S)', lambda m: time.sleep(0.3), 'idict', Key('escape')],
    'surround string'       : ['S)', lambda m: time.sleep(0.3), 'istr', Key('escape')],
    'surround integer'      : ['S)', lambda m: time.sleep(0.3), 'iint', Key('escape')],
    'surround'              : ['S)', lambda m: time.sleep(0.3), 'i', Key('escape')],
}

plugins.update({'%d jedi' % k: [Key('ctrl-j')]*k for k in range(2, 10)})
plugins.update({'%d kitty' % k: [Key('ctrl-k')]*k for k in range(2, 10)})
vimmap.update(plugins)

primitive_commands = {
    'undo'                  :  [Key('escape'), "u"],
    'redo'                  :  Key('escape ctrl-r'),

    'oozey' : Key("ctrl-o"),

    'bar'         : 'V',
    'block'       : Key('ctrl-v'),

    # SmartInner
    'winner'      : 'in',
    'wander'      : 'an',
    'bender'      : 'il',
    'banter'      : 'al',

    'make upper' :  'gU',
    'make lower' :  'gu',
    'soldier'    :  'gq',

    # register stuff
    'reggie': '"',

    # marker stuff
    'privvy'       : [Key("escape"), "''"],
    'last change'  : "'.",
    'belect'       : "'<",
    'alect'        : "'>",

    'edit'         : Key('%s e space' % LEADER),
    'source'       : [":so", Key('space')],
    'settings'     : [":set", Key('space')],
    'settings paste'     : [":set", Key("space"), "paste", Key("enter")],
    'settings no paste'     : [":set", Key("space"), "nopaste", Key("enter")],

    # search stuff
    'cancel hits' :  ["/asde", Key("enter")],
    'nex'         :  Key("n"),
    'bex'         :  Key("N"),
    'sore'        :  [":s///g"] + [Key("left")]*3,
    'globsore'    :  [":%s///g"] + [Key("left")]*3,

    # Folding stuff
    'cold':  [initial_pos_click, 'zA'],
    'mold': [initial_pos_click, 'za'],
    'monster': [initial_pos_click, 'zAzmzo'],
    'enrolled': [initial_pos_click, 'zR'],

    'para' : [Key("escape"), "o", Key("enter")],
}; vimmap.update(primitive_commands)

make_marker = lambda marker_key, *args: [Key("left right escape"), Str("m%s" % marker_key)]

#  return function that can be called with None
def final_pos_click_function(m):
    def inner(*args):
        final_pos_click(m)
    return inner

#  return function that can be called with None
def initial_pos_click_function(m):
    def inner(*args):
        initial_pos_click(m)
    return inner

text_selectors = {
    "whale"      : "iw",
    "ship whale" : "iW",
    "each"       : "e",
    "ship each"  : "E",
    "bat"        : "b",
    "ship bat"   : "B",
    "doll"       : "$",
    "mod"        : "%",
    "zero"       : "0",
    "flex"       : "^",
    "sit larry"  : "i(",
    "sit lack"   : "i[",
    "sit lace"   : "i{",
    "sit langle" : "i<",
    "sit sote"   : "i'",
    "sit quote"  : "i\"",
    "air larry"  : "a(",
    "air lack"   : "a[",
    "air lace"   : "a{",
    "air langle" : "a<",
    "air sote"   : "a'",
    "air quote"  : "a\"",
}

target_required_text_selectors = {
    "fail"       : "f",
    "til"        : "t",
    "gif"        : "F",
    "lit"        : "T",
}

teleport_commands = [
    'psych',
    'big-psych', # paste with P instead of p
    'steal',
    'slice',
    'kill',
    'kit',
    'phipps',
    'clippy',
]

here_to_here_commands = [
    'phipps',
    'bar',
    'block',
    'kill',
    'kill-test',
    'steal',
    'psych',
    'big-psych', # paste with P instead of p
    'stack',
    'comment',
    'uncomment',
    'triple-quote',
    'linecert',
    'clippy',
    'run',
]

movement_targets = lower_upper_digits.copy()
movement_targets.update(punctuation)

def TeleportCommand(m):
    '''Teleport commands are a group of commands that carry out keystrokes both at the mouse\'s position
       AND the cursor's position at the time of first utterance. It is called teleport because the cursor
       'teleports' between these two positions. The general flow of this function is:

            1. make a marker at the cursor's position
            2. click where the mouse was at the start of the utterance
            3. carry out keystrokes for the command (e.g. select text, etc)
            4. optionally return to the marker and carry out more keystrokes (e.g. paste text, etc)

       The concept of these commands was seeded by the command `psych`, which is demonstrated in this
       video: https://www.youtube.com/watch?v=F2KEnQl7d2s
    '''
    utterance = []
    for w in m._words:
        utterance.append(w.word)

    teleport_movement = utterance[1:]
    teleport_operator = utterance[0]

    marker_key = 't' # marks original cursor position

    if teleport_operator == "psych":
        actions_dict = {
            'preprend': Str('y'),
            'append': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker_key)), Str('pa')]
                        if not DISABLE_WINDOW_SWAPPING
                        else [Str("'{}".format(marker_key)), Str('pa')])
        }

    elif teleport_operator == "big-psych":
        actions_dict = {
            'preprend': Str('y'),
            'append': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker_key)), Str('Pa')]
                        if not DISABLE_WINDOW_SWAPPING
                        else [Str("'{}".format(marker_key)), Str('Pa')])
        }

    elif teleport_operator == "steal":
        actions_dict = {
            'preprend': Str('y'),
            'append': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker_key))]
                        if not DISABLE_WINDOW_SWAPPING
                        else [Str("'{}".format(marker_key))])
        }

    elif teleport_operator == "slice":
        actions_dict = {
            'preprend': Str('d'),
            'append': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker_key)), Str('pa')]
                        if not DISABLE_WINDOW_SWAPPING
                        else [Str("'{}".format(marker_key)), Str('pa')])
        }

    elif teleport_operator == "kill":
        actions_dict = {
            'preprend': Str('d'),
            'append': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker_key))]
                        if not DISABLE_WINDOW_SWAPPING
                        else [Str("'{}".format(marker_key))])
        }

    elif teleport_operator == "kit":
        actions_dict = {
            'preprend': Str('c'),
            'append': Str(""),
        }

    elif teleport_operator == "phipps":
        actions_dict = {
            'preprend': Str('v'),
            'append': Str(""),
        }

    elif teleport_operator == "clippy":
        actions_dict = {
            'preprend': Str('v'),
            'append': ([Key("ctrl-y"), Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker_key))]
                        if not DISABLE_WINDOW_SWAPPING
                        else [Key('ctrl-y'), Str("'{}".format(marker_key))])
        }

    else:
        raise Exception("`{}` is not a keyword understood by TeleportCommand (vim.py)".format(teleport_operator))

    actions_dict.update({
        'make_marker': make_marker(marker_key, m),
        'mark_start_window': ([Str(':let winA = win_getid()'), Key('enter')]
                              if not DISABLE_WINDOW_SWAPPING
                              else Str('')),
        'initial_pos_click': initial_pos_click_function(m)
    })

    if len(teleport_movement):
        movement_strokes = ''
        if ' '.join(teleport_movement) in text_selectors:
            # the motion is self-contained; no number prefixes or movement targets
            movement_strokes += text_selectors[' '.join(teleport_movement)]
        else:
            # movement key or number prefix was uttered. fish them out
            if teleport_movement[0] in [str(x) for x in list(range(10))]:
                # the movement has been prefixed by a number (e.g. `2 til larry`)
                movement_strokes += teleport_movement.pop(0)
            movement_strokes += target_required_text_selectors[teleport_movement.pop(0)]
            movement_strokes += movement_targets[' '.join(teleport_movement)]
    else:
        # no movement stroke was specified, assuming 'inside word'
        movement_strokes = 'iw'

    actions_dict['movement_strokes'] = Str(movement_strokes)

    action_order = [
        'make_marker',
        'mark_start_window',
        'initial_pos_click',
        'preprend',
        'movement_strokes',
        'append',
    ]
    for action_name in action_order:
        action = actions_dict.get(action_name)
        if action:
            if hasattr(action, '__iter__'):
                # catches cases like [Key(...), Str(...), ...]
                for act in action:
                    act(None)
            else:
                # catches simpler cases like Key(...)
                action(None)


def HereToHereCommand(m):
    '''`Here-to-here` commands select and sometimes operate on a text selection defined by where the
       mouse is at the start and end of the utterance. In this sense the user sweeps with their eyes
       the text selection as they utter `<command_prefix> here to here`. They can also use
       `<command_prefix> to here` to use the starting cursor position as the first text selection
       point, or `<command_prefix> here` to select either a single character or line.'''
    utterance = []
    for w in m._words:
        utterance.append(w.word)

    marker1 = 't' # original cursor pos
    marker2 = 'y' # position of first click
    marker3 = 'u' # position of second click

    command_prefix = utterance[0]

    if command_prefix == 'phipps':
        actions_dict = {
            'selection_type': Str("v"),
            'selection_movement': Str("'{}".format(marker3)),
        }

    elif command_prefix == 'block':
        actions_dict = {
            'selection_type': Key("ctrl-v"),
            'selection_movement': Str("'{}".format(marker3)),
        }

    elif command_prefix == 'bar':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
        }

    elif command_prefix == 'kill':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Str("d"),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
        }

    elif command_prefix == 'run':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': [Str("R"), Key('ctrl-l'), Str('a')],
        }

    elif command_prefix == 'steal':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Str("y"),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
        }

    elif command_prefix == 'triple-quote':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Str("S3\""),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
        }

    elif command_prefix == 'clippy':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Key("ctrl-y"),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
        }

    elif command_prefix == 'psych':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Str("y"),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
            'after_return_to_start': Str("p"),
        }

    elif command_prefix == 'big-psych':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Str("y"),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
            'after_return_to_start': Str("P"),
        }

    elif command_prefix == 'stack':
        actions_dict = {
            'selection_type': Str("V"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Str("y"),
            'after_stroke': Str("'>p".format(marker1)),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
        }

    elif command_prefix == 'linecert':
        actions_dict = {
            'before_selection': Str('^'),
            'selection_type': Key("ctrl-v"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Key("^ shift-i"),
        }

    elif command_prefix == 'comment':
        actions_dict = {
            'before_selection': Str('^'),
            'selection_type': Key("ctrl-v"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Key("shift-i # space esc"),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
        }

    elif command_prefix == 'uncomment':
        actions_dict = {
            'before_selection': Str('^'),
            'selection_type': Key("ctrl-v"),
            'selection_movement': Str("'{}".format(marker3)),
            'selection_ending_stroke': Key("^ right d"),
            'return_to_start': ([Str(':call win_gotoid(winA)'), Key('enter'), Str("'{}".format(marker1))]
                                 if not DISABLE_WINDOW_SWAPPING
                                 else [Str("'{}".format(marker1))]),
        }


    actions_dict.update({
        'make_marker1': make_marker(marker1, m),
        'make_marker3': make_marker(marker3, m),
        'mark_start_window': [Str(':let winA = win_getid()'), Key('enter')] if not DISABLE_WINDOW_SWAPPING else Str(''),
        'final_pos_click': final_pos_click_function(m),
        'initial_pos_click': initial_pos_click_function(m)
    })

    command_variant_name = ' '.join(utterance[1:])

    if command_variant_name == 'here to here':
        action_order = [
            'make_marker1',
            'mark_start_window',
            'final_pos_click',
            'make_marker3',
            'initial_pos_click',
            'before_selection',
            'selection_type',
            'selection_movement',
            'selection_ending_stroke',
            'after_stroke',
            'return_to_start',
            'after_return_to_start',
        ]

    elif command_variant_name == 'to here':
        actions_dict['return_to_cursor'] = Str("'{}".format(marker1))
        action_order = [
            'make_marker1',
            'final_pos_click',
            'make_marker3',
            'return_to_cursor',
            'before_selection',
            'selection_type',
            'selection_movement',
            'selection_ending_stroke',
            'after_stroke',
            'return_to_start',
            'after_return_to_start',
        ]

    elif command_variant_name == 'here':
        action_order = [
            'make_marker1',
            'make_marker3',
            'initial_pos_click',
            'before_selection',
            'selection_type',
            'selection_ending_stroke',
            'after_stroke',
            'return_to_start',
            'after_return_to_start',
        ]

    for action_name in action_order:
        action = actions_dict.get(action_name)
        if action:
            if hasattr(action, '__iter__'):
                # catches cases like [Key(...), Str(...), ...]
                for act in action:
                    act(None)
            else:
                # catches simpler cases like Key(...)
                action(None)


# everything mouse-related
mouse_map = {
    '(%s) [((%s) | [(%s)] (%s) [(%s)])]' % (' | '.join(teleport_commands),
                                            ' | '.join(list(text_selectors.keys())),
                                            ' | '.join([str(x) for x in list(range(10))]),
                                            ' | '.join(list(target_required_text_selectors.keys())),
                                            ' | '.join(list(movement_targets.keys()))): TeleportCommand,
    '(%s) (here to here | to here | here)' % (' | '.join(here_to_here_commands)): HereToHereCommand,
    'go to | go here' :  [initial_pos_click, Key('%s' % LEADER), "d"],
}; vimmap.update(mouse_map)

common_names = {
    "dido" : "d$",
    "leader" : Key("%s" % LEADER),
}; vimmap.update(common_names)

ctx.keymap(vimmap)
