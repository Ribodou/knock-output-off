# knock-output-off
A way to contact servers protected by port knocking

## how to use this ?

Simply download this git directory.

In your ~/.bashrc file (or ~/.zshrc file), add :

`
alias sshopen="/path/to/directory/sshopen.sh"

alias sshclose="/path/to/directory/sshclose.sh"
`

open /path/to/directory/mySSHTools.sh and replace adresses with the list of the ports you want to knock and domain.ext with the actual domain you want to connect to.
