// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Just enough HTTP to download a single file

package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"
)

func download(path string, url string) error {
	out, err := os.Create(path + ".tmp")
	if err != nil {
		return err
	}
	defer out.Close()

	// GET request
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// Report progress if possible
	var reader io.Reader = resp.Body
	size, err := strconv.ParseUint(resp.Header.Get("Content-Length"), 10, 64)
	if err == nil && size != 0 {
		reader = io.TeeReader(reader, &progressWriter{total: size})
	}

	// Stream to tempfile
	_, err = io.Copy(out, reader)
	if err != nil {
		return err
	}

	// Can't rename an open file in Windows
	out.Close()

	if err = os.Rename(out.Name(), path); err != nil {
		return err
	}

	return nil
}

type progressWriter struct {
	count, total, percent uint64
}

func (wc *progressWriter) Write(p []byte) (int, error) {
	wc.count += uint64(len(p))

	percent := 100 * wc.count / wc.total

	for i := wc.percent + 10; i <= percent; i += 10 {
		wc.percent = i

		suffix := "% "
		if i == 100 {
			suffix = "%\n"
		}

		fmt.Printf("%d%s", i, suffix)
	}

	return len(p), nil
}
