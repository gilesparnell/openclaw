# Rugby Calendar Context for Gilo

**Created:** 2026-02-03
**Updated:** 2026-02-03
**Context:** Personal calendar management for Gilo's children's sporting events

## Family Context
Gilo has 4 children with ex-wife (separated Dec 2024 after 28 years together):
- **Lily** - 17, born UK, grew up in South Africa
- **Ferne** - 14, born South Africa  
- **Griffin & Connor** - 10, born Australia (the rugby players!)

Gilo is South African and deeply misses home. Has a new girlfriend Jackie Nash ("Petal/Vonnies/NashFace") visiting from SA to test living in Australia.

These rugby calendars are for Griffin & Connor's sporting commitments.

## What We Did
Added **41 total sporting events** for Griffin & Connor to calendar `giloandloops@gmail.com` for the 2026 season:
- 23 x G&C Tigers (Rugby Union) 
- 18 x G&C Sharkies (Rugby League)

## Event Structure

### Tigers (Rugby Union)
- **Title format:** `G&C Tigers: [Event Name]`
- **Day:** Sundays
- **Time:** 09:00-11:00 (2 hours)
- **Location:** TBC (to be updated later)

### Sharkies (Rugby League)  
- **Title format:** `G&C: Sharkies: [Event Name]`
- **Day:** Saturdays  
- **Time:** 09:00-11:00 (2 hours)
- **Location:** TBC (to be updated later)

**Both:** AEST timezone, reminders set to calendar default (need manual update to 1 day before)

## Season Overview

### G&C Tigers (Rugby Union - Sundays)
- **Grading Day:** March 29 (pre-season)
- **RD1-RD13:** Sundays, April 26 - August 23
- **State Champs:** June 6-8 (3 days)
- **U12 Dev Gala:** July 4-5 (2 days) - Narrabeen Tigers hosting
- **State Gala U10/U11:** July 18-19 (2 days)
- **Semi-Final:** August 30
- **Grand-Final:** September 6 (Father's Day)

### G&C: Sharkies (Rugby League - Saturdays)
- **RD1-RD15:** Saturdays, April 11 - August 8
- **Semi Finals:** August 15
- **Finals:** August 22
- **Grand Finals:** August 29
- **Bye Weeks:** Apr 4-5 (Easter), Apr 25-26 (Anzac), Jun 6-7 (Kings Bday), Jul 11-12 (School Holidays)

**Note:** No clashes between Tigers (Sundays) and Sharkies (Saturdays) - good scheduling!

## Status
✅ All 41 events created successfully (23 Tigers + 18 Sharkies)
⏳ Awaiting actual game times from Gilo to update events

## Next Steps (When Gilo Returns)
- Update event times from generic 9-11am to actual game times for both teams
- Update locations from "TBC" to actual grounds
- Set reminders to 1 day before (requires manual Google Calendar setting)
- May need to adjust for any schedule changes
- Add any additional tournaments/gala days as they're announced

## Command Reference
```bash
gog calendar update giloandloops@gmail.com <event_id> --from "2026-XX-XXTHH:MM:SS+10:00" --to "2026-XX-XXTHH:MM:SS+10:00"
```
