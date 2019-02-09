read -p "Enter Pool name :" poolname 
rados -p $poolname  ls | sed -n '/'$poolname'*/,$p'  > metadata.txt
if [ 'echo "$?' != "0" ]; then
          for value in `cat metadata.txt`
do
    ceph osd map $poolname  "$value" | awk '{print $13,$14}' | cut -d',' -f1,2 | tail -c 5 | cut -d']' -f1
done
else
          echo -e "\nPlease Enter valid PoolName ......"
         
fi 
