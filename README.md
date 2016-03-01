# homeOS-cookbook

Setup:
  fail2ban
  selinux
  firewall
  influxdb
  grafana
  collectd
  rabbitmq
  nginx (https TBC)
  letsencrypt (self-signed)
  

## Supported Platforms

Tested on CentOS 7, but should work on other linux distro if you had the correct deps.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['name']</tt></td>
    <td>String</td>
    <td>Node name</td>
    <td><tt></tt></td></tr><tr>
    <td><tt>['inter_username']</tt></td>
    <td>String</td>
    <td>Username used between different components</td>
    <td><tt></tt></td></tr><tr>
    <td><tt>['inter_password']</tt></td>
    <td>String</td>
    <td>Password used between different components</td>
    <td><tt></tt></td></tr><tr>
    <td><tt>['ddns_token']</tt></td>
    <td>String</td>
    <td>Token used to update duckdns.org -- Sorry this is hardcoded for now</td>
    <td><tt></tt></td></tr><tr>
    <td><tt>['ddns']</tt></td>
    <td>String</td>
    <td>Domain for duckdns.org -- Sorry this is hardcoded for now</td>
    <td><tt>duckdns.org</tt></td>
  </tr>
</table>

## Usage

### On your wokstation:
  * Install Chef dk
  * Clone this repo https://github.com/chaton78/homeOS.git
  * Update solo.rb and web.json (for each node) to your liking
  * Run this:
  ```bash
  berks package
  ```
  
  Upload cookbooks-*.tar.gz, web.json and solo.rb to your new VPS.
  
### On your VPS:
Force some setting, (we are using cloud at cost)
  ```bash
  nmcli con mod "System eth0" ipv4.dns "8.8.8.8 8.8.4.4"
  hostname YOUR_HOSTNAME
  hostnamectl set-hostname YOUR_HOSTNAME --transient
  ```
Update your image, take a coffee.. this is C@C.
  ```bash
  yum -y update
  ```
Install chef
  ```bash
  curl -L https://www.opscode.com/chef/install.sh | bash
  ```
Untar-ungzip your cookbooks

Run 
  ```bash
  chef-solo -c solo.rb -j web.json
  ```

## License and Authors

Author:: Pascal Larin <plarin@gmail.com>
