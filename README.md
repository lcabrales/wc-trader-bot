# World Challenges Trader Bot

Use this to track your WC pieces and their status (owned, seeking or trade), and to easily check the status of a specific piece between all users.

# Commands

## !piece set

Set the status of a piece in your collection.

### Syntax

```!piece set {status} {world} {piece}```

* `{status}` - One of `owned`, `seeking`, `trade`, `none`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{piece}` - Piece number. Example: 1.10.

### Examples

* To mark the piece Neopia Central 1.10 as owned: 

```!piece set owned NC 1.10```

* To mark the piece Tyrannia 2.5 as trade: 

```!piece set trade NC 1.10```

* To remove the status of Space Station 2.6 in your collection:

```!piece set none VP 2.6```

## !piece list

Displays a list of pieces from a specific user's collection.

### Syntax

```!piece list {status} {world} {user}```

* `{status}` - One of `owned`, `seeking`, `trade`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{user}` - Optional. Mention a server user to view their collection or leave blank to view your collection.

#### Examples

* To view all the pieces you own:

```!piece list owned all```

* To view all the pieces you seek from Faerieland:

```!piece list owned FL```

* To view all the pieces a user @JonDoe has for trade:

```!piece list trade all @JonDoe```

## !piece search

Searches for a piece in the specified status in all users' collections.

### Syntax

```!piece search {status} {world} {piece}```

* `{status}` - One of `owned`, `seeking`, `trade`.
* `{world}` - Two-letter world abbreviation (check the World Abbreviations section).
* `{piece}` - Piece number. Example: 1.10.

### Examples

* To search which users want the piece Terror Mountain 2.17:

```!piece search seeking TM 2.17```

* To search which users have the piece Haunted Woods 3.6 up for trade:

```!piece search trade HW 3.6```