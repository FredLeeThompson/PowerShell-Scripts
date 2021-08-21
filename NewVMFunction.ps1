function Add-NewVM {
[CmdletBinding()]
param ([string]$Name, $Mem, $VHDSize)

New-VM -Name $Name -MemoryStartupBytes $Mem -Path C:\'Virtual Machines'\$File
Set-VMMemory -VMName $Name -DynamicMemoryEnabled $true -StartupBytes $Mem -MinimumBytes $Mem -Verbose
if ($?) {
"A new VM named " + $Name + " has been created! Now creating a virtual hard disk..."}
else {"There was a problem creating the VM!"}

Invoke-NewVHD $Name $VHDSize -verbose
if ($?) {"A VHD named '$Name.vhdx' has been created! Now we will connect '$Name.vhdx' to the VM '$Name'..."}
else {"There was aproblem creating the VHD named '$Name'!"}

Connect-NewVHD $Name -verbose
if ($?) {"The VHD named '$Name.vhdx' has been connected to the VM '$Name'!"} 
else {"The VHD failed to connect to the virtual machine!"}
};