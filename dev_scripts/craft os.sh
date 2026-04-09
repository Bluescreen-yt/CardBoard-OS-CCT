clear
rm -rf ../computers
mkdir ../computers ../computers/0
cp ../src/* ../computers/0/ -r
craftos --start-dir ../computers/0
rm -rf ../computers