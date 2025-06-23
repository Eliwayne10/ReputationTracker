# ReputationTracker Smart Contract

A simple badge leaderboard system built with Clarity for the Stacks blockchain.

## Overview

ReputationTracker enables an admin to award badges to users and keeps track of badge counts per user. It also provides functions to query badge counts and compare users for leaderboard purposes.

## Features

- **Award Badges:** Only the contract owner can award badges to users.
- **Query Badges:** Anyone can check how many badges a user has.
- **Leaderboard:** Compare two users and return the one with more badges.

## Contract Functions

| Function            | Access      | Description                                      |
|---------------------|-------------|--------------------------------------------------|
| `award-badge`       | Public      | Admin awards a badge to a user                   |
| `get-user-badges`   | Read-only   | Returns the badge count for a user               |
| `get-leader`        | Read-only   | Compares two users and returns the leader        |

## Usage Examples

### Award a Badge

```clarity
(award-badge 'ST123...456)
```
*Only the contract owner can call this function.*

### Get User Badges

```clarity
(get-user-badges 'ST123...456)
```

### Compare Two Users

```clarity
(get-leader 'ST123...456 'ST789...012)
```

## Security Notes

- All user input is type-checked as `principal`.
- All map lookups use `default-to` to ensure safe default values.
- Only the contract owner can award badges.

