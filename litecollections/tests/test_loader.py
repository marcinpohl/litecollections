from hypothesis import given
from hypothesis.strategies import text

from litecollections.loader import load, dump

@given(text())
def test_decode_inverts_encode(s):
    print(s)
    assert load(dump(s)) == s


if __name__ == "__main__":
    print('test_decode_inverts_encode')
    test_decode_inverts_encode()
    print('done')
