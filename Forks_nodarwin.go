// +build !darwin

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

func darwinForksExist(path string) bool {
	return false
}

func darwinFInfo(path string) ([32]byte, error) {
	panic("Darwin")
}

func setDarwinFInfo(path string, finfo [32]byte) error {
	panic("Darwin")
}
