[![CI](https://github.com/de-it-krachten/ansible-role-windows_storage/workflows/CI/badge.svg?event=push)](https://github.com/de-it-krachten/ansible-role-windows_storage/actions?query=workflow%3ACI)


# ansible-role-windows_storage

Initialize Windows storage (disk format)



## Dependencies

#### Roles
None

#### Collections
- community.general
- community.windows

## Platforms

Supported platforms

- Windows 2012 R2<sup>1</sup>
- Windows 2016<sup>1</sup>
- Windows 2019<sup>1</sup>
- Windows 2022<sup>1</sup>

Note:
<sup>1</sup> : no automated testing is performed on these platforms

## Role Variables
### defaults/main.yml
<pre><code>
windows_storage_list: []
</pre></code>




## Example Playbook
### molecule/default/converge.yml
<pre><code>
- name: sample playbook for role 'windows_storage'
  hosts: all
  become: "yes"
  vars:
    windows_storage: {'disks': [{'disk_number': 1}, {'disk_number': 2}], 'partitions': {'absent': [{'disk_number': 1, 'partition_number': 1}, {'disk_number': 1, 'partition_number': 2}, {'disk_number': 2, 'partition_number': 1}], 'present': [{'disk_number': 1, 'drive_letter': 'X', 'file_system': 'ntfs', 'partition_number': 1, 'partition_size': '100 MiB'}, {'disk_number': 1, 'drive_letter': 'Y', 'file_system': 'ntfs', 'partition_number': 2, 'partition_size': '200 MiB'}, {'disk_number': 2, 'drive_letter': 'Z', 'file_system': 'ntfs', 'partition_number': 1, 'partition_size': -1}]}}
  tasks:
    - name: Include role 'windows_storage'
      ansible.builtin.include_role:
        name: windows_storage
</pre></code>
