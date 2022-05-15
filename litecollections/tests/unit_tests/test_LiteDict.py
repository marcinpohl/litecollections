#!/usr/bin/env python
# -*- coding: utf-8 -*-

from unittest import TestCase
from random import getrandbits

from litecollections import LiteDict

'''
class TestStringMethods(unittest.TestCase):

    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            s.split(2)

if __name__ == '__main__':
    unittest.main()
'''

def random_bytes():
    return getrandbits(128).to_bytes(16, 'little')

class TestLiteDict(TestCase):
    def test_int_keys(self):
        d = LiteDict()
        for k in range(10):
            assert k not in d
            assert k == len(d), [k, len(d)]
            d[k] = 'waffle'
            assert k in d
            assert d[k] == 'waffle', repr(d[k])
            assert k+1 == len(d), [k+1, len(d)]
            print(k, len(d), k in d, d[k], k+1 in d)
            print(d)
            print(repr(d))
            print()

    def test_str_keys(self):
        d = LiteDict()
        for _k in range(10):
            k=str(_k)
            assert k not in d, [k, d.keys()]
            assert _k == len(d), [_k, len(d)]
            d[k] = 'waffle'
            assert k in d, [k, d.keys()]
            assert d[k] == 'waffle', repr(d[k])
            assert _k+1 == len(d), [_k+1, len(d)]
            print(_k, len(d), k in d, d[k], str(_k+1) in d)
            print(d)
            print(repr(d))
            print()

    def test_random_byte_keys(self):
        with LiteDict() as d:
            for _k in range(10):
                k=random_bytes()
                assert k not in d, [k, d.keys()]
                assert _k == len(d), [_k, d]
                d[k] = 'waffle'
                assert k in d, [k, d.keys()]
                assert d[k] == 'waffle', repr(d[k])
                assert _k+1 == len(d), [_k+1, len(d)]
                print(_k, len(d), k in d, d[k], str(_k+1) in d)
                print(d)
                print(repr(d))
                print()
                
    def test_str_keys_with_persistence(self):
        print('now for persistence (this should fail if ran twice)')
        with LiteDict('persistent_dict.db') as d:
            for _k in range(10):
                k=str(_k)
                assert k not in d, [k, d.keys()]
                assert _k == len(d), [_k, d]
                d[k] = 'waffle'
                assert k in d, [k, d.keys()]
                assert d[k] == 'waffle', repr(d[k])
                assert _k+1 == len(d), [_k+1, len(d)]
                print(_k, len(d), k in d, d[k], str(_k+1) in d)
                print(d)
                print(repr(d))
                print()
    


if __name__ == '__main__':
