echo "---test the filesystem---"
./fshost testfs lfs
echo "---test IPC---"
./test-caller caller server server1
echo "---test relay-page---"
./host relay-page
echo "---test mem---"
./host mem 5
echo "---test fastboot---"
./fork-host mem 5
echo "---test stop resume and destroy---"
./test-stop loop
echo "---test psa storage---"
./psahost psa_client psa_server decouplefs_simple/filesystem decouplefs_simple/persistency