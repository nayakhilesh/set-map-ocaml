(* A list-based map. Bindings always sorted ascending by key. *)

type ('k, 'v) map = ('k * 'v) list

let empty: ('k, 'v) map = []

let is_empty (m: ('k, 'v) map): bool =
  m = []

let rec mem (key: 'k) (m: ('k, 'v) map): bool =
  begin match m with
  | [] -> false
  | (k, _) :: t -> k = key || (k < key && mem key t)
  end

let rec find (key: 'k) (m: ('k, 'v) map): 'v =
  begin match m with
  | [] -> failwith "Cmap.find key not found"
  | (k, v) :: t ->
      if k = key then v
      else find key (if k < key then t else [])
  end

let rec add (key: 'k) (value: 'v) (m: ('k, 'v) map): ('k, 'v) map =
  begin match m with
  | [] -> [(key, value)]
  | (k, v) :: t ->
      if k < key then (k, v) :: add key value t
      else (key, value) :: (if k = key then t else m)
  end

let rec union (m: ('k, 'v) map) (n: ('k, 'v) map): ('k, 'v) map =
  begin match m with
  | [] -> n
  | (k, v) :: t ->
      begin match n with
      | [] -> m
      | (k', v') :: t' ->
	  if k < k' then (k, v) :: (union t n)
	  else if k' < k then (k', v') :: (union m t')
	  else if v = v' then (k', v') :: (union t t')
	  else failwith "Cmap.union found a key mapped to two different values"
      end
  end

let rec remove (key: 'k) (m: ('k, 'v) map): ('k, 'v) map =
  begin match m with
  | [] -> []
  | (k, v) :: t ->
      if k < key then (k, v) :: (remove key t)
      else if k = key then t
      else m
  end

let rec keys (m: ('k, 'v) map): 'k list =
  begin match m with
  | [] -> []
  | (k, _) :: t -> k :: (keys t)
  end

let rec filter (f: ('k * 'v) -> bool) (m: ('k, 'v) map): ('k, 'v) map =
  begin match m with
  | [] -> []
  | h :: t -> if (f h) then h :: (filter f t) else filter f t
  end

let rec values (m: ('k, 'v) map): 'v list =
  begin match m with
  | [] -> []
  | (_, v) :: t -> v :: (values t)
  end

let bindings (m: ('k, 'v) map): ('k * 'v) list =
  m

let rec string_of_map_helper (string_of_key : 'k -> string) (string_of_val : 'v -> string)
                              (m : ('k, 'v) map): string =
  begin match m with
  | [] -> ""
  | (k,v)::[] -> string_of_key k ^ " -> " ^ string_of_val v
  | (k,v)::tl -> string_of_key k ^ " -> " ^ string_of_val v 
                 ^ "; " ^ string_of_map_helper string_of_key string_of_val tl
  end

let from_list (kvs: ('k * 'v) list) : ('k, 'v) map =
  List.fold_right (fun (k,v) m -> add k v m) kvs empty

let string_of_map (string_of_key : 'k -> string) (string_of_val : 'v -> string)
                   (m : ('k, 'v) map): string =
  "{" ^ string_of_map_helper string_of_key string_of_val m ^ "}"
