[![CI](https://github.com/de-it-krachten/ansible-role-windows_storage/workflows/CI/badge.svg?event=push)](https://github.com/de-it-krachten/ansible-role-windows_storage/actions?query=workflow%3ACI)


# ansible-role-windows_storage

Initialize Windows storage (disk format)<br><br>
Note that GPT disks have a reserved partition '1' after initialization<br>



## Dependencies

#### Roles
None

#### Collections
- community.windows

## Platforms

Supported platforms

- Ubuntu 24.04 LTS
- Windows Server 2012 R2<sup>1</sup>
- Windows Server 2016<sup>1</sup>
- Windows Server 2019<sup>1</sup>
- Windows Server 2022<sup>1</sup>

Note:
<sup>1</sup> : no automated testing is performed on these platforms

## Role Variables
### defaults/main.yml
<pre><code>
# Show extra information
windows_storage_verbose: false

# Field mapping
windows_storage_fields:
  SATA:
    adapter: SCSIPort
    disk: SCSIBus
  SAS:
    adapter: SCSIPort
    # disk: SCSILogicalUnit  # Azure VMs
    disk: SCSITargetId       # Virtualbox VM's
</pre></code>




## Example Playbook
### molecule/default/converge.yml
<pre><code>
- name: sample playbook for role 'windows_storage'
  hosts: all
  become: 'yes'
  vars:
    windows_storage_disk_layout:
      - type: SATA
        adapter: 0
        disk: 1
        style: gpt
        partitions:
          - drive_letter: X
            file_system: ntfs
            partition_number: 2
            partition_size: 100 MiB
            allocation_unit_size: 8192
          - drive_letter: Y
            file_system: ntfs
            partition_number: 3
            partition_size: 200 MiB
            compress: true
      - type: SATA
        adapter: 0
        disk: 2
        style: mbr
        partitions:
          - drive_letter: Z
            file_system: ntfs
            partition_number: 1
            partition_size: -1
            label: myfulldisk
  roles:
    - deitkrachten.facts
  tasks:
    - name: Include role 'windows_storage'
      ansible.builtin.include_role:
        name: windows_storage
</pre></code>
