# -*- coding: utf-8 -*-
"""
"""


import weechat
from time import sleep
from threading import Timer

DUCK_SHOOTER_SRV ="9.subluminal"
DUCK_SHOOTER_CHAN="#programming"
DUCK_SHOOTER_NAME="%s.%s" % (DUCK_SHOOTER_SRV, DUCK_SHOOTER_CHAN)

SHOOT_STRING = ".bang"
SAVE_STRING = ".bef"
TRIGGER_MSGS= ["\_0<",
               "\_o<",
               "\_O<",
               "\_∅<",
               "\_Ö<",
               "\_ö<",
              ]

def notify(data, buf, date, tags, displayed, hilight, prefix, msg):
    name = weechat.buffer_get_string(buf, "name")
    sname = weechat.buffer_get_string(buf, "short_name")

    if (name == DUCK_SHOOTER_NAME):
        for trigger in TRIGGER_MSGS:
          if trigger in msg:
            send_msg = ".bang"
            write_to_buffer(buf, sname, SHOOT_STRING)
    #elif TRIGGER_MSG in msg:
    #  weechat.prnt(buf, "TRIGGER FOUND, WRONG CHAN")
    #elif name == DUCK_SHOOTER_CHAN:
    #  weechat.prnt(buf, "MSG IN CHAN, NO TRIGGER")
    return weechat.WEECHAT_RC_OK

def write_to_buffer(buf, bufname, str):
    #buffer = weechat.info_get("irc_buffer", buf)
    cmd = "/msg -server %s %s %s" %(DUCK_SHOOTER_SRV, bufname, str)
    weechat.prnt(buf, "TRIGGERED: %s" % cmd)
    weechat.command('', cmd)

def go_main():
    weechat.register("DUCK_SHOOTER", "Nick", "1.0", 
                     "FUCK OFF", "...", "", "")

    weechat.hook_print('', 'irc_privmsg', '', 1, 'notify', '')
    #weechat.hook_command('duck_shooter', '', '', '', 'send_msg', '')

if __name__ == "__main__":
    go_main()

