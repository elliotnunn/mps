package main

// TODO: make this much better
func quote(s macstring) macstring {
	return macstring("'") + s + macstring("'")
}
