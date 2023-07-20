# World Challenges Trader Bot

Use this to track your WC pieces and their status (owned, seeking or trade), and to easily check the status of a specific piece between all users.

# Quick Setup

Let's say you are starting to use the bot and have no pieces tracked yet. The fastest way to get started is by bulk adding your owned and trade pieces, then defining which map you are seeking.

For example, the user is working on Neopia Central 1 and owns the pieces 1.4, 1.8, 1.10, 1.14 and 1.20. The user also has the following pieces up for trade: HW 2.5, FL 2.16, TM 1.9 and TM 2.12. Here's how that would look in commands:

* Marking the owned Neopia Central 1 pieces:

```?piece set owned NC 1.4 1.8 1.10 1.14 1.20```

* Marking all the other Neopia Central 1 pieces as seeking:

```?piece setother seeking NC 1```

* Marking the pieces that are up for trade (one command for each world):

```?piece set trade HW 2.5```

```?piece set trade FL 2.16```

```?piece set trade TM 1.9 2.12```

That's it!

# Piece Commands

## ?piece set

Set the status of a piece in your collection.

### Syntax

```?piece set {status} {world} {pieces}```

* `{status}` - One of `owned`, `seeking`, `trade`, `remove`. Note, you can also use `none` as an alias for `remove`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{pieces}` - Piece number. Can be multiple of the same world separeted by spaces. Example: `1.10 1.16 1.20`

### Examples

* To mark the piece Neopia Central 1.10 as owned: 

```?piece set owned NC 1.10```

* To mark the piece Tyrannia 2.5 as trade: 

```?piece set trade NC 1.10```

* To remove the status of Space Station 2.6 in your collection:

```?piece set remove VP 2.6```

* To mark the pieces Krawk Island 3.1, 3.6 and 3.10 as owned:

```?piece set owned KI 3.1 3.6 3.10```

## ?piece setother

Set all pieces that are unnassigned (no status) to a specific status in your collection.

### Syntax

```?piece setother {status} {world} {map}```

* `{status}` - One of `owned`, `seeking`, `trade`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{map_number}` - Map number. Example: `1`.

### Examples

* To mark all unnassigned pieces of Lost Desert 3 as seeking:

```?piece setother seeking LD 3```

## ?piece list

Displays a list of pieces from a specific user's collection.

### Syntax

```?piece list {status} {world} {user}```

* `{status}` - One of `owned`, `seeking`, `trade`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{user}` - Optional. Mention a server user to view their collection or leave blank to view yours.

#### Examples

* To view all the pieces you own:

```?piece list owned all```

* To view all the pieces you seek from Faerieland:

```?piece list owned FL```

* To view all the pieces a user @JonDoe has for trade:

```?piece list trade all @JonDoe```

## ?piece search

Searches for a piece in the specified status in all users' collections.

### Syntax

```?piece search {status} {world} {piece}```

* `{status}` - One of `owned`, `seeking`, `trade`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{piece}` - Piece number. Example: `1.10`.

### Examples

* To search which users want the piece Terror Mountain 2.17:

```?piece search seeking TM 2.17```

* To search which users have the piece Haunted Woods 3.6 up for trade:

```?piece search trade HW 3.6```

# Map Commands

## ?map set

Use this to set the status of all map pieces.

**WARNING:** this will override the status of *every* piece of that map in your collection.

### Syntax

```?map set {status} {world} {map}```

* `{status}` - One of `owned`, `seeking`, `trade`, `remove`. Note, you can also use `none` as an alias for `remove`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{map}` - Map number. Example: `1`.

### Examples

* To set all the pieces of Haunted Woods 1 as owned:

```?map set owned HW 1```

* To set all the pieces of Faerieland 2 as seeking:

```?map set seeking FL 2```

* To remove all pieces of Terror Mountain 1 from your collection (this includes every status):

```?map set remove FL 2```

## ?map complete

Use this to mark a certain map as completed. It will remove all the pieces marked as owned for that specific map.

Pieces with other status, such as seeking or trade, will not be affected.

### Syntax

```?map complete {world} {map}```

* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{map}` - Map number. Example: `1`.

### Examples

* To complete Neopia Central 3:

```?map complete NC 3```

## ?map search

Use this to search for all users that have at least one piece set to the specified `status` for the specified map.

### Syntax

```?map search {status} {world} {map}```

* `{status}` - One of `owned`, `seeking`, `trade`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{map}` - Map number. Example: `1`. Optional.

### Examples

* To search for all users that own any piece of any KI map:

```?map search owned KI```

* To search for all users that own any piece of FL 3:

```?map search owned KI```

* To search for all users that are seeking any piece of any HW map:

```?map search seeking HW```


# World Abbreviations

| World Name        | Abbreviation |
|-------------------|--------------|
| Faerieland        | FL           |
| Haunted Woods     | HW           |
| Krawk Island      | KI           |
| Kreludor          | KD           |
| Lost Desert       | LD           |
| Maraqua           | MQ           |
| Meridell          | MD           |
| Mystery Island    | MI           |
| Neopia Central    | NC           |
| Terror Mountain   | TM           |
| Tyrannia          | TY           |
| Virtupets         | VP           |