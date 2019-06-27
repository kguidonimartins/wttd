def verbing(s):
    if len(s) < 3:
        verb = s
    elif s[-3:] == "ing":
        verb = s.replace(s[-3:], "ly")
    else:
        verb = "".join([s, "ing"])
    return verb

verbing("aaaaing")
verbing("adsf")
verbing("qw")


a = ["not", "bad"]

dinner = "this dinner is not so bad"
import re
"is not" in dinner

re.sub("not*bad", "good", dinner)

dinner.replace("not * bad", "good")

dir(dinner)

dinner.split(" ")


dinner.split().index("not")
dinner.split()[3:]
dinner = "this dinner is not so bad"

w = re.search('not', dinner)

dinner.find("n")


if w:
    found = w.group(1)

found

print(w.group(1))

["not", "bad"] in dinner

if "not" in dinner.split(" "):
    dinner = dinner.replace("not", "")
if "bad" in dinner.split(" "):
    dinner = dinner.replace("bad", "")
dinner = dinner + "good"
dinner = " ".join(dinner.split())
return dinner

print(dinner)
