## Write Ansible ad-hoc commands below

# Create new file called /opt/test.sh
# Set owner of the file to ansible
# Set mode to 0755
ansible localhost -b -m file -a 'state=touch name=/opt/test.sh mode=0755 owner=ansible'


# Add content to the file:
# #!/bin/sh
# echo hi there

ansible -b localhost -m lineinfile -a 'line="#!/bin/sh\necho hi there" path=/opt/test.sh'