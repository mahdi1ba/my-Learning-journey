export ANSIBLE_GATHERING=explicit

ansible -m ping all

ansible -a 'cat /etc/hosts' all

ansible-playbook playbook.yml

#chmod 755 shell-script.sh
#./shell-script.sh
