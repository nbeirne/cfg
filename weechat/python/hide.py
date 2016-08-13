# -*- coding: utf-8 -*-
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#
# History:
#     version 0.1: initial release

import weechat as w

SCRIPT_NAME    = "hide"
SCRIPT_AUTHOR  = "Nick"
SCRIPT_VERSION = "0.1"
SCRIPT_LICENSE = "GPL3"
SCRIPT_DESC    = "Auto show and hide bars"

SCRIPT_COMMAND = "hide"

settings = {
    'action'  : 'toggle', # show or hide or toggle. default action
    'bars': '',  #csv of bars to toggle, when there are no inputs
}


def get_bar_list():
    bars = w.config_get_plugin('bars')
    if bars == '':
        return []
    else:
        return bars.split(',')

def do_action(bars, action):
    for bar in bars:
        cmd = '/bar %s %s' % (action, bar)
        w.command('', cmd)
    #w.prnt('', 'toggled => %s' % str(bars))

def bars_cmd_cb(data, buffer, raw_args):
    ''' Command /nicklist '''
    if raw_args == '':
        bars = get_bar_list()
        action = w.config_get_plugin('action')
        do_action(bars, action)

    else:
        args = raw_args.split(' ')
        action = w.config_get_plugin('action')
        bars = args[0].split(',')
        if (len(args) > 1):
            action = args[1] # guarenteed by raw_args == ''
        do_action(bars, action)
    return w.WEECHAT_RC_OK


if w.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, "", ""):
    for option, default_value in settings.items():
        if not w.config_is_set_plugin(option):
            w.config_set_plugin(option, default_value)

    w.hook_command(SCRIPT_COMMAND,
                   #description
                   "Show or hide bars",
                   # args
                   "[bar] [show|hide|toggle action]",
                   # arg descriptions
                   "bar: the bars to toggle, comma seperated.\n"
                   "\n"     
                   "[action]:\n"
                   "   show: show the bars in the list\n"
                   "   hide: hide the bars in the list\n"
                   " toggle: show/hide the bars in the list\n"
                   "you can set the bar list with: "
                   "/set plugins.var.python.%s.bars \"xxx\"."
                   % SCRIPT_NAME,
                   # completions
                   "%(bars_names)"
                   "show|hide",
                   "bars_cmd_cb", "")
