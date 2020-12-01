from powerline_shell.utils import BasicSegment
import os

FG_NORMAL = '0'
BG_NORMAL = '15'
FG_INSERT = '0'
BG_INSERT = '12'


class Segment(BasicSegment):
    def add_to_powerline(self):
        vimode = os.environ['VIMODE']

        if vimode == 'NORMAL':
            fg = FG_NORMAL
            bg = BG_NORMAL
        elif vimode == 'INSERT':
            fg = FG_INSERT
            bg = BG_INSERT
        else:
            fg = FG_NORMAL
            bg = BG_NORMAL

        self.powerline.append(
            ' %s ' % vimode,
            fg,
            bg)
