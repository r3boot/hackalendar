#!/usr/bin/env python

import re
import yaml
import sys

re_start_event = re.compile('^BEGIN:VEVENT')
re_end_event   = re.compile('^END:VEVENT')

event_re = {
    'StartDate': re.compile('^DTSTART.*DATE:([0-9]{4})([0-9]{2})([0-9]{2})$'),
    'EndDate': re.compile('^DTEND.*DATE:([0-9]{4})([0-9]{2})([0-9]{2})$'),
    'Name': re.compile('^SUMMARY:(.*)$'),
    'URL': re.compile('^URL:(.*)$'),
    'Comment': re.compile('^COMMENT:(.*)$'),
}

if __name__ == '__main__':
    in_event = False
    all_events = []
    event = {}
    for line in sys.stdin.readlines():
        line = line.strip()
        match = re_start_event.search(line)
        if match:
            in_event = True

        if in_event:
            for key, regex in event_re.items():
                match = regex.search(line)
                if match:
                    if 'Date' in key:
                        event[key] = "{0}-{1}-{2}".format(match.group(1),match.group(2),match.group(3))
                    else:
                        event[key] = match.group(1)

        match = re_end_event.search(line)
        if match:
            all_events.append(event)
            event = {}
    print(yaml.dump(all_events))
