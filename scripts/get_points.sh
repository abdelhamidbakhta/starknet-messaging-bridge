#get_points PLAYER_ADDRESS
player=$1

# Get the number of points in hexadecimal
output=$(nile call Points balanceOf $player | tail -1  | cut -d' ' -f1)
# Convert hex string to uppercase
output=$(eval cut -d "x" -f 2 <<< "$output" | tr '[:lower:]' '[:upper:]')
# Convert hex to decimal
points=$(echo "obase=10; ibase=16; $output" | bc)
# Truncate decimals
points=$(eval echo $points | awk '{ print substr( $0, 1, length($0)-18 ) }')
echo "Points: $points"