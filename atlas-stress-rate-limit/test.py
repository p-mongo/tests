import dns.resolver

while True:
    answers = dns.resolver.query('dnspython.org', 'MX')
    for rdata in answers:
        print('Host', rdata.exchange, 'has preference', rdata.preference)
