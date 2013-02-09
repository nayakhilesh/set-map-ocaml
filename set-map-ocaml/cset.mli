(* All implementations must support structural equality tests. *)
type 'a set
val empty: 'a set
val is_empty: 'a set -> bool
val mem: 'a -> 'a set -> bool
val add: 'a -> 'a set -> 'a set
val union: 'a set -> 'a set -> 'a set

(* Outputs the input set if the element is not in the set. *)
val remove: 'a -> 'a set -> 'a set

val filter: ('a -> bool) -> 'a set -> 'a set

(* Converts a set to a list *)
val elements: 'a set -> 'a list

(* Number of elements in the set *)
val size : 'a set -> int

(* Converts a list to a set. *)
val from_list: 'a list -> 'a set

(* Converts a set to a string for printing *)
val string_of_set : ('a -> string) -> 'a set -> string

