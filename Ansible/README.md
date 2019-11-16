# Ansible #

- Ansible task one is to install apache and copy over the webserver html, css, and js files to those EC2 instances.

- This must be done through the bastion set up to transfer it to the webservers as the middle-man.

- Ansible task two is to install fail2ban on the bastion in order to make it more secure.

## Website ##

### Instructions ###

**1)** Take the generated {{user}}.pem file and move it to ~/.ssh/{{user}}.pem

**2)** Enter the hosts file, and replace {{webserver1 ip}} & {{webserver2 ip}} & {{bastion ip}} with the correct IP addresses.

**3)** Enter the hosts file, and replace {{user}}.pem with correct .pem file.

**4)** Move hosts file to etc/ansible and replace default hosts file.

**5)** Navigate to Terraform/Ansible and run **sudo ansible-playbook website.yml**

### Documentation ###

**website.yml**

    - hosts: bastion
      become: true
      gather_facts: false
      pre_tasks:
      - name: 1) Install python2
    raw: bash -c "test -e /usr/bin/python || (apt -qqy update && apt -y upgrade && apt install -qqy python-minimal)"
    register: output
    changed_when: output.stdout != ""
      - name: 2) Gather files and tasks
    setup:
      roles:
    - apache2
    - php-fpm

**hosts**

    # This is the default ansible 'hosts' file.
    #
    # It should live in /etc/ansible/hosts
    #
    #   - Comments begin with the '#' character
    #   - Blank lines are ignored
    #   - Groups of hosts are delimited by [header] elements
    #   - You can enter hostnames or ip addresses
    #   - A hostname/ip can be a member of multiple groups
    
    # Ex 1: Ungrouped hosts, specify before any group headers.
    
    ## green.example.com
    ## blue.example.com
    ## 192.168.100.1
    ## 192.168.100.10
    
    # Ex 2: A collection of hosts belonging to the 'webservers' group
    
     [webservers]
    
    {{webserver1_ip}} ansible_ssh_private_key_file=~/.ssh/{{user}}.pem ansible_ssh_user=ubuntu
    
    {{webserver2_ip}} nsible_ssh_private_key_file=~/.ssh/{{user}}.pem ansible_ssh_user=ubuntu
    
    
     [bastion]
    
    {{bastion_ip}} ansible_ssh_private_key_file=~/.ssh/projec1.pem ansible_ssh_user=ubuntu
    
    # If you have multiple hosts following a pattern you can specify
    # them like this:
    
    ## www[001:006].example.com
    
    # Ex 3: A collection of database servers in the 'dbservers' group
    
    ## [dbservers]
    ## 
    ## db01.intranet.mydomain.net
    ## db02.intranet.mydomain.net
    ## 10.25.1.56
    ## 10.25.1.57
    
    # Here's another example of host ranges, this time there are no
    # leading 0s:
    
    ## db-[99:101]-node.example.com

**apache2 main.yml**

      
    - name: 3) Install apache2
      become: true
      apt: pkg={{ item }} state=latest update_cache=true
      with_items:
      - apache2
    
    - name: 4) Upload apache2 000-default.conf
      become: yes
      copy: src=files/000-default.conf dest=/etc/apache2/sites-enabled/
    
    - name: 5) Remove default apache2 index.html
      become: yes
      ignore_errors: yes
      command: rm /var/www/html/index.html 
    
    - name: 6) Upload index.html 
      become: yes
      copy: src=files/index.html dest=/var/www/html/ mode=0644  
    
    - name: 7) Upload script.js
      become: yes
      copy: src=files/script.js dest=/var/www/html/ mode=0644
    
    - name: 8) Upload style.css
      become: yes
      copy: src=files/style.css dest=/var/www/html/ mode=0644
    
    - name: 9) Restart webserver
      become: yes
      service: name=apache2 state=restarted

**php-fpm main.yml**

    - name: 10) Install php & extensions
      become: true
      apt: pkg={{ item }} state=latest update_cache=true
      with_items:
      - php-fpm
      - php-gd
      - php-curl
      - php-dom
      - php-xml
    
    - name: 11) Deploy php Configuration with apache2
      become: true
      copy: src=files/www.conf dest=/etc/php/7.0/fpm/pool.d/
    
    - name: 12) Restart php-fpm
      become: yes
      service: name=php7.2-fpm state=restarted

## Fail2ban ##

### Instructions ###

**1)** Navigate to Terraform/Ansible and run **sudo ansible-playbook fail2ban.yml**

### Documentation ###

**fail2ban.yml**

    - hosts: bastion
      become: yes
      gather_facts: false
      tasks:
      
      - name: install fail2ban packages
    apt: 
      name: "{{ item }}"   
      state: latest
      update_cache: yes
      cache_valid_time: 3600
    with_items:
      - fail2ban
    
      - name: Create a directory
    file:
      path: /etc/test
      state: directory
      mode: '0755'