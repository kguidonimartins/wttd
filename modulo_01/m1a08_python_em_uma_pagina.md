# M1A08: Python em uma página

```python
import os


def main():
    print('Hello world!')
    print("This is Alice's greeting.")
    print('This is Bob\'s greeting.')

    foo(5, 10)

    print('=' * 10)
    text = 'The current working directory is '
    print (text + os.getcwd())

    foods = ['apples', 'oranges', 'cats']

    for food in foods:
        print('I like to eat', food)

    print('Count to ten:')
    for i in range(1, 11):
        print(i)

def foo(a, b):
    value = a + b

    print('%s plus %s is equal to %s' % ( a, b, value))

    if value < 50:
        print('foo')
    elif (value >= 50) and  ((a == 42) or (b == 24)):
        print('bar')
    else:
        print('moo')

    '''A multi-
    line stringj but can also be a multi-line comment.'1'
    return value # This is a one-Line comment'''

    return value # This is one comment

if __name__ == '__main__':
    main()
```
