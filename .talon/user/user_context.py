from talon.voice import Context as TalonContext

blacklist = ('SpeechTexter', 'Duolingo')

class Context(TalonContext):
    def __init__(self, name, app=None, exe=None, bundle=None, title=None, func=None, group=None, blacklist=blacklist):
        # if no func is passed, create trivial function
        if func is None:
            func = lambda app, win: True

        function = lambda app, win: func(app, win) and all(s not in win.title for s in blacklist)
        TalonContext.__init__(self, name, app=None, exe=None, bundle=None, title=None, func=function, group=None)

