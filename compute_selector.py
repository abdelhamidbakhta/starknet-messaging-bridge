# python3 compute_selector.py NAME
# ex: python3 compute_selector.py deposit
import sys
from starkware.starknet.compiler.compile import \
    get_selector_from_name

name = sys.argv[1]
print(get_selector_from_name(name))