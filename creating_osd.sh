read -p "Enter uuid or id of the OSD :" uuid
ceph osd create $uuid
read -p "Enter the OSD  host :" osdhost
ssh $osdhost
read -p "Enter the OSD number: " osdnumber
sudo mkdir /var/lib/ceph/osd/ceph-$osdnumber
read -p "Enter disk  path of physical machine :" drivepath
sudo mkfs -t xfs $drivepath
sudo mount -a  $drivepath /var/lib/ceph/osd/ceph-$osdnumber
ceph-osd -i $osdnumber --mkfs --mkkey
ceph auth add osd.$osdnumber osd 'allow *' mon 'allow rwx' -i /var/lib/ceph/osd/ceph-$osdnumber/keyring
read -p "Enter weight of the OSD:" $weight
read -p "Enter Bucket Type :" $buckettype
read -p "Enter Bucket Name(host) :" $bucketname
ceph osd crush add osd.$osdnumber $weight $buckettype = $bucketname
~                                                                            
