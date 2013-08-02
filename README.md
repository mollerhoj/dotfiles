This my dotfiles. Finally under version control.

To get CAPS LOCK as tmux key:

Use PCKeyboardHack, and set CAPS LOCK as 80 Key

In iTerm2 set Option_R to Esc+

KeyRemap4MacBook, with this script:
<?xml version="1.0"?>
<root>
    <item>
        <name>F19 to F19</name>
        <appendix>F19 to OPTION_R</appendix>
        <identifier>private.f192f19_escape</identifier>
        <autogen>
            --KeyOverlaidModifier--
            KeyCode::F19,
            KeyCode::OPTION_R,
            ModifierFlag::OPTION_R,
            KeyCode::OPTION_R
        </autogen>
    </item>
</root>

#To remove font-changes in iterm2, open terminal and run:
#defaults write com.googlecode.iterm2 PinchToChangeFontSizeDisabled -bool true



Instructions

install git
clone dotfiles
run setuplinks script
download macvim, drap to applications, and move to /usr/bin/mvim
install rvm

mkdir $HOME/bin


<?xml version="1.0"?>
<root>
    <item>
        <name>Change Backquote Key to Escape</name>
        <identifier>private.right_command_to_escape</identifier>
        <autogen>__KeyToKey__ KeyCode::BACKQUOTE, KeyCode::ESCAPE</autogen>
    </item>
    <item>
        <name>Change Crazy Key to Tilde</name>
        <identifier>private.crazy_to_tilde</identifier>
        <autogen>__KeyToKey__ KeyCode::RUSSIAN_PARAGRAPH, KeyCode::RUSSIAN_TILDE</autogen>
    </item>
</root>

