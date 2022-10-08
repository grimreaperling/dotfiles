# Plugin source helper
_source_plugin() {
	local plugin_name="$1"
	for basedir in ~/.zsh/plugins
	do
		plugin="$basedir/$plugin_name/$plugin_name.zsh"
		[ -f "$plugin" ] && source "$plugin" && return 0
	done
	echo "\033[33m[ ! ]\033[0m ZSH ${plugin_name#zsh-} not installed"
	return 1
}

# ZSH Autosuggestions
_source_plugin zsh-autosuggestions && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

# Manually load the F-Sy-H
source ~/.zsh/plugins/F-Sy-H/F-Sy-H.plugin.zsh

# POWERLEVEL
if ! [[ $(tty) = /dev/tty* ]]
then
	if source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme 2> /dev/null
	then
		# General config
		POWERLEVEL9K_MODE='nerdfont-complete'
		POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

		# Prompts
		if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon ssh context dir virtualenv vcs)
		else
		  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir virtualenv vcs)
		fi
		POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator battery custom_now_playing time)
		POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
		POWERLEVEL9K_SHORTEN_DELIMITER=..
		POWERLEVEL9K_PROMPT_ON_NEWLINE=true
		POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
		#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
		POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
		POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰\uF460\uF460\uF460 "

		# Colors
		POWERLEVEL9K_VIRTUALENV_BACKGROUND=107
		POWERLEVEL9K_VIRTUALENV_FOREGROUND='white'
		POWERLEVEL9K_CUSTOM_NOW_PLAYING_BACKGROUND='blue'
		POWERLEVEL9K_CUSTOM_NOW_PLAYING_FOREGROUND='black'
		POWERLEVEL9K_OS_ICON_BACKGROUND='white'
		POWERLEVEL9K_OS_ICON_FOREGROUND='black'
		POWERLEVEL9K_TIME_BACKGROUND='white'
		POWERLEVEL9K_TIME_FOREGROUND='black'

		# Battery colors
		POWERLEVEL9K_BATTERY_CHARGING='107'
		POWERLEVEL9K_BATTERY_CHARGED='blue'
		POWERLEVEL9K_BATTERY_LOW_THRESHOLD='50'
		POWERLEVEL9K_BATTERY_LOW_COLOR='red'
		POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND='blue'
		POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='white'
		POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND='107'
		POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='white'
		POWERLEVEL9K_BATTERY_LOW_BACKGROUND='red'
		POWERLEVEL9K_BATTERY_LOW_FOREGROUND='white'
		POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='white'
		POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND='214'

		# VCS colors
		POWERLEVEL9K_VCS_CLEAN_FOREGROUND='cyan'
		POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
		POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='white'
		POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='red'
		POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
		POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'

	else
		echo '\033[33m[ ! ]\033[0m ZSH powerlevel10k not installed'
	fi
else
	clear
	echo
	echo
fi


switch_powerlevel_multiline_prompt(){
	[ $POWERLEVEL9K_PROMPT_ON_NEWLINE = true ] \
		&& POWERLEVEL9K_PROMPT_ON_NEWLINE=false \
		|| POWERLEVEL9K_PROMPT_ON_NEWLINE=true

	zle && zle accept-line
}
zle -N switch_powerlevel_multiline_prompt
bindkey ^P switch_powerlevel_multiline_prompt
