## Run

1. Populate the database:

    ruby insert.rb

2. Build:

    go build

3. Run:

    ./hello

## Result

    carbon% ./hello
    round 0: 10000 documents retrieved
    round 1: 20000 documents retrieved
    round 2: 30000 documents retrieved
    round 3: 40000 documents retrieved
    round 4: 50000 documents retrieved
    round 5: 60000 documents retrieved
    round 6: 70000 documents retrieved
    round 7: 80000 documents retrieved
    round 8: 90000 documents retrieved
    round 9: 100000 documents retrieved
    round 10: 110000 documents retrieved
    round 11: 120000 documents retrieved
    round 12: 130000 documents retrieved
    round 13: 140000 documents retrieved
    round 14: 150000 documents retrieved
    round 15: 160000 documents retrieved
    round 16: 170000 documents retrieved
    round 17: 180000 documents retrieved
    round 18: 190000 documents retrieved
    round 19: 200000 documents retrieved
    round 20: 210000 documents retrieved
    round 21: 220000 documents retrieved
    round 22: 230000 documents retrieved
    round 23: 240000 documents retrieved
    round 24: 250000 documents retrieved
    round 25: 260000 documents retrieved
    round 26: 270000 documents retrieved
    round 27: 280000 documents retrieved
    round 28: 290000 documents retrieved
    round 29: 300000 documents retrieved
    round 30: 310000 documents retrieved
    round 31: 320000 documents retrieved
    round 32: 330000 documents retrieved
    round 33: 340000 documents retrieved
    round 34: 350000 documents retrieved
    round 35: 360000 documents retrieved
    round 36: 370000 documents retrieved
    round 37: 380000 documents retrieved
    round 38: 390000 documents retrieved
    round 39: 400000 documents retrieved
    round 40: 410000 documents retrieved
    round 41: 420000 documents retrieved
    round 42: 430000 documents retrieved
    round 43: 440000 documents retrieved
    round 44: 450000 documents retrieved
    round 45: 460000 documents retrieved
    round 46: 470000 documents retrieved
    round 47: 480000 documents retrieved
    round 48: 490000 documents retrieved
    round 49: 500000 documents retrieved
    round 50: 500897 documents retrieved
    panic: context deadline exceeded

    goroutine 1 [running]:
    main.check(...)
            /home/w/apps/tests/go-find-fail/tut.go:17
    main.main()
            /home/w/apps/tests/go-find-fail/tut.go:41 +0x56b
