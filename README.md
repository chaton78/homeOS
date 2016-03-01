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

### homeOS::default

Include `homeOS` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[homeOS::default]"
  ]
}
```

## License and Authors

Author:: Pascal Larin <plarin@gmail.com>
