import weechat

SCRIPT_NAME     = 'toggle_time'
SCRIPT_AUTHOR   = 'Maarten de Vries <maarten@de-vri.es>'
SCRIPT_VERSION  = '0.1'
SCRIPT_LICENSE  = 'GPL3'
SCRIPT_DESC     = 'Toggle the time'

WEECHAT_TIME_CONFIG = 'weechat.look.buffer_time_format'
WEECHAT_ITEM_TIME_CONFIG = 'weechat.look.item_time_format'

def on_toggle_time_command(data, buffer, args):
    ''' Called when the autosort command is invoked. '''
    args = args.split(' ')
    action = args[0]

    if action == 'toggle' or len(args) == 0:
        toggle_time()
    elif action == 'on' or action == 'off':
        set_time_state(action)
    else:
        weechat.prnt('', 'Cannot toggle time: Unknown action %s' % action)

    return weechat.WEECHAT_RC_OK

def toggle_time():
    config_ptr = weechat.config_get(WEECHAT_TIME_CONFIG)
    format = weechat.config_string(config_ptr)
    if format == '':
        set_time_state('on')
    else:
        set_time_state('off')

def set_time_state(state):
    config_ptrs = [weechat.config_get(WEECHAT_TIME_CONFIG),
                   weechat.config_get(WEECHAT_ITEM_TIME_CONFIG)]
    format = weechat.config_get_plugin('format')

    if state == 'off':
        format = ''

    for ptr in config_ptrs:
        weechat.config_option_set(ptr, format, 1)

def on_time_format_changed(data, option, value):
    if value == '':
        return weechat.WEECHAT_RC_OK
    weechat.config_set_plugin('format', value)
    return weechat.WEECHAT_RC_OK

command_description = r'''
/toggle_time toggle
/toggle_time on
/toggle_time off
'''

command_completion = 'toggle|on|off'


if weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, "", ""):
    weechat.hook_command('toggle_time', command_description, '', '', command_completion, 'on_toggle_time_command', 'NULL')
    weechat.hook_config(WEECHAT_TIME_CONFIG, 'on_time_format_changed', '')
    weechat.hook_config(WEECHAT_ITEM_TIME_CONFIG, 'on_time_format_changed', '')

    config_ptr = weechat.config_get(WEECHAT_TIME_CONFIG)
    format = weechat.config_string(config_ptr)
    on_time_format_changed('', '', format)
