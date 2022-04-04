%lang starknet
%builtins pedersen range_check ecdsa

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.messages import send_message_to_l1

#
# Declaring storage vars
#

@storage_var
func l1_evaluator_address_storage() -> (l1_evaluator_address : felt):
end

@storage_var
func rand_value_storage() -> (rand__value : felt):
end

#
# Constructor
#

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
_l1_evaluator_address: felt):
    l1_evaluator_address_storage.write(_l1_evaluator_address)
    return ()
end

# ######## External functions

@l1_handler
func solution{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        from_address : felt, rand_value : felt):
    let (l1_evaluator_address) = l1_evaluator_address_storage.read()
    with_attr error_message("Message was not sent by the official L1 contract"):
        assert from_address = l1_evaluator_address
    end
    rand_value_storage.write(rand_value)
    return ()
end

func l1_assigned_var{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
) -> (assigned_var: felt):
    let (assigned_var) = rand_value_storage.read()
    return (assigned_var)
end