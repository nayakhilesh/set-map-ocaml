type 'a set = ('a, unit) Cmap.map

let empty: 'a set = Cmap.empty

let is_empty (s: 'a set): bool = Cmap.is_empty s

let mem (key: 'a) (s: 'a set): bool = Cmap.mem key s

let add (key: 'a) (s: 'a set): 'a set = Cmap.add key () s

let union (s: 'a set) (t: 'a set): 'a set = Cmap.union s t

let remove (key: 'a) (s: 'a set): 'a set = Cmap.remove key s

let filter (f: 'a -> bool) (s: 'a set): 'a set =
  Cmap.filter (fun x -> f (fst x)) s

let elements (s: 'a set): 'a list = Cmap.keys s

let rec string_of_set_helper (string_of_a: 'a -> string) (s: 'a list) : string =
  begin match s with
  | [] -> ""
  | a::[] -> string_of_a a
  | a::tl -> string_of_a a ^ ", " ^ string_of_set_helper string_of_a tl
  end

let string_of_set (string_of_a: 'a -> string) (s: 'a set) : string =
  "{" ^ string_of_set_helper string_of_a (elements s) ^ "}"
  

let size (s: 'a set): int =
  List.fold_right (fun (x: 'a) (y: int) -> 1 + y) (elements s) 0

let from_list (e: 'a list): 'a set =
  List.fold_right (fun (x: 'a) (y: 'a set) -> add x y) e empty 
