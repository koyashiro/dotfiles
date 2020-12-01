from powerline_shell.utils import BasicSegment
import os

FG_NORMAL = '0'
BG_NORMAL = '15'
FG_INSERT = '0'
BG_INSERT = '12'
FG_VISUAL = '0'
BG_VISUAL = '11'


class Segment(BasicSegment):
    def add_to_powerline(self):
        vimode = os.getenv('VIMODE')

        if vimode is None:
            return

        if vimode == 'NORMAL':
            fg = FG_NORMAL
            bg = BG_NORMAL
        elif vimode == 'INSERT':
            fg = FG_INSERT
            bg = BG_INSERT
        elif vimode == 'VISUAL':
            fg = FG_VISUAL
            bg = BG_VISUAL
        else:
            fg = FG_NORMAL
            bg = BG_NORMAL

        self.powerline.append(
            ' %s ' % vimode,
            fg,
            bg)
