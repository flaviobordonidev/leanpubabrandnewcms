
## Ruby hashes

Ruby hashes are similar to arrays. A hash literal uses braces rather than square brackets. The literal must supply two objects for every entry: one for the key, the other for the value. For example, you may want to map musical instruments to their orchestral sections:

 	inst_section = {
 	:cello => 'string',
 	:clarinet => 'woodwind',
 	:drum => 'percussion',
 	:oboe => 'woodwind',
 	:trumpet => 'brass',
 	:violin => 'string'
 	}
The thing to the left of the => is the key, and that on the right is the corresponding value. Keys in a particular hash must be unique—you can’t have two entries for :drum. The keys and values in a hash can be arbitrary objects—you can have hashes where the values are arrays, other hashes, and so on. In Rails, hashes typically use symbols as keys. Many Rails hashes have been subtly modified so that you can use either a string or a symbol interchangeably as a key when inserting and looking up values.

Use of symbols as hash keys is so commonplace that starting with Ruby 1.9 there is a special syntax for it, saving both keystrokes and eyestrain.

 	inst_section = {
 	cello: 'string',
 	clarinet: 'woodwind',
 	drum: 'percussion',
 	oboe: 'woodwind',
 	trumpet: 'brass',
 	violin: 'string'
 	}
Doesn’t that look much better?

Feel free to use whichever syntax you like. You can even intermix usages in a single expression. Obviously you’ll need to use the arrow syntax whenever the key is not a symbol, or if you are using Ruby 1.8.7. However, most developers seem to prefer the new syntax, and Rails will even generate scaffolds using the new syntax if it detects that you are running Rails 1.9.2.

Hashes are indexed using the same square bracket notation as arrays:

 	inst_section[:oboe] #=> 'woodwind'
 	inst_section[:cello] #=> 'string'
 	inst_section[:bassoon] #=> nil
As the previous example shows, a hash returns nil when indexed by a key it doesn’t contain. Normally this is convenient, because nil means false when used in conditional expressions.

You can pass hashes as parameters on method calls. Ruby allows you to omit the braces, but only if the hash is the last parameter of the call. Rails makes extensive use of this feature. The following code fragment shows a two-element hash being passed to the redirect_to method. In effect, though, you can ignore that it’s a hash and pretend that Ruby has keyword arguments.

 	redirect_to action: 'show', id: product.id


