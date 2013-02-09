(* All implementations must support structural equality tests. *)
type ('k, 'v) map
val empty: ('k, 'v) map
val is_empty: ('k, 'v) map -> bool
val mem: 'k -> ('k, 'v) map -> bool

(* Fails with error if the key cannot be found. *)
val find: 'k -> ('k, 'v) map -> 'v

(* Replaces any existing binding for the key. *)
val add: 'k -> 'v -> ('k, 'v) map -> ('k, 'v) map

(* Fails with error if a key is mapped to two different values. *)
val union: ('k, 'v) map -> ('k, 'v) map -> ('k, 'v) map

(* Outputs the input map if the key has no binding. *)
val remove: 'k -> ('k, 'v) map -> ('k, 'v) map

val filter: (('k * 'v) -> bool) -> ('k, 'v) map -> ('k, 'v) map
val keys: ('k, 'v) map -> 'k list
val values: ('k, 'v) map -> 'v list
val bindings: ('k, 'v) map -> ('k * 'v) list

val from_list : ('k * 'v) list -> ('k, 'v) map

(* Convert a map to a string for printing. *)
val string_of_map : ('k -> string) -> ('v -> string) 
                     -> ('k, 'v) map -> string
