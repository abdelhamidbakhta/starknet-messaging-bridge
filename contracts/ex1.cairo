%lang starknet
%builtins pedersen range_check ecdsa

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.messages import send_message_to_l1

#
# Declaring storage vars
#

@storage_var
func l1_nft_messaging_address_storage() -> (l1_nft_messaging_address : felt):
end

#
# Constructor
#

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
_l1_nft_messaging_address: felt):
    l1_nft_messaging_address_storage.write(_l1_nft_messaging_address)
    return ()
end

# ######## External functions

@external
func create_l1_nft_message{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
l1_user: felt):
    let (l1_nft_messaging_address) = l1_nft_messaging_address_storage.read()
    let (message_payload: felt*) = alloc()
    assert message_payload[0] = l1_user
    send_message_to_l1(
        to_address=l1_nft_messaging_address,
        payload_size=1,
        payload=message_payload)

    return ()
end