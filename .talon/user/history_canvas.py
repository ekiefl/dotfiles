from talon import ui, ctrl
from talon.engine import engine
from talon.canvas import Canvas

hist_len = 3

class History:
    def __init__(self):
        self.history = []
        engine.register('post:phrase', self.on_phrase_post)
        self.canvas = Canvas.from_screen(ui.main_screen())
        self.canvas.register('draw', self.draw)

    def parse_phrase(self, phrase):
        return ' '.join(word.split('\\')[0] for word in phrase)

    def on_phrase_post(self, j):
        phrase = self.parse_phrase(j.get('phrase', []))
        cmd = j['cmd']
        if cmd == 'p.end' and phrase:
            self.history.append(phrase)
            self.history = self.history[-hist_len:]
            self.canvas.freeze()

    def draw(self, canvas):
        text = self.history[:]
        if not text:
            return
        paint = canvas.paint
        paint.filter_quality = paint.FilterQuality.LOW
        paint.textsize = 15
        paint.antialias = True

        # canvas.draw_res is a long testct(ui.Rect(x - 50, y - 50, 100, 100))
        x = canvas.x + 1595
        y = canvas.y + 50
        text_pad = 0
        rect_pad = 6

        # measure text
        width = 0
        text_top = y
        text_bot = y
        line_spacing = 0
        for line in text:
            _, trect = paint.measure_text(line)
            width = max(width, trect.width)
            line_spacing = max(line_spacing, trect.height)
            text_top = min(text_top, y - trect.height)

        line_spacing += text_pad
        text_bot = y + (len(text) - 1) * line_spacing
        height = text_bot - text_top

        rect = ui.Rect(x - rect_pad, text_top - 2, -width - rect_pad * 2, height + rect_pad + 2)
        paint.color = 'ffffffaa'
        paint.style = paint.Style.FILL
        canvas.draw_round_rect(rect, 3, 3)

        paint.color = '000000'
        paint.style = paint.Style.FILL
        for line in text:
            _, trect = paint.measure_text(line)

            canvas.draw_text(line, x - trect.width - rect_pad * 2, y)
            y += line_spacing


history = History()
