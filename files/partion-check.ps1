# rc=0 : partition present and correct in size
# rc=2 : partition not present
# rc=3 : partition present but too small

param(
  [int]$DiskNumber,
  [int]$PartitionNumber,
  [int]$DesiredSize
)

$p = Get-Partition -DiskNumber $DiskNumber -PartitionNumber $PartitionNumber -ErrorAction SilentlyContinue
if (-not $p) { exit 2 }  # missing

# Size check
if ($DesiredSize -eq -1) {
  # "Use max" mode: check if already at maximum supported size
  $supp = Get-PartitionSupportedSize -DiskNumber $DiskNumber -PartitionNumber $PartitionNumber
  if ($p.Size -ge ($supp.SizeMax - 1MB)) { exit 0 } else { exit 3 }
} else {
  $tolerance = 1MB
  if ([math]::Abs([int64]$p.Size - [int64]$DesiredSize) -le $tolerance) { exit 0 } else { exit 3 }
}
