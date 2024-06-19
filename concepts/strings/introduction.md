# Introduction

In Cairo, there's no native type for strings. Instead, you can use a single
`felt252` to store a short string of up to 31 characters, or a `ByteArray`
for strings of arbitrary length. Short strings use single quotes and
`ByteArray` uses double quotes. All characters must follow the ASCII standard.
