# Public Protected Private

I> il codice "protected" è prima del codice "private" perché è meno restrittivo.
I>
I> Dal più accessibile al più restrittivo abbiamo: "public" -> "protected" -> "private"


Risorse interne:

* 01-base/13-roles/04-implement_roles
* 01-base/15-authorization/03-authorization-users


Risorse web:

* [Ruby Access Control](http://rubylearning.com/satishtalim/ruby_access_control.html)


The only easy way to change an object's state in Ruby is by calling one of its methods. Control access to the methods, and you have controlled access to the object. A good rule of the thumb is never to expose methods that could leave an object in an invalid state.

Ruby gives you three levels of protection:

* Public methods can be called by everyone - no access control is enforced. A class's instance methods (these do not belong only to one object; instead, every instance of the class can call them) are public by default; anyone can call them. The initialize method is always private.
* Protected methods can be invoked only by objects of the defining class and its subclasses. Access is kept within the family. However, usage of protected is limited.
* Private methods cannot be called with an explicit receiver - the receiver is always self. This means that private methods can be called only in the context of the current object; you cannot invoke another object's private methods.

Access control is determined dynamically, as the program runs, not statically. You will get an access violation only when the code attempts to execute the restricted method. Let us refer to the program p047classaccess.rb below:

# p047classaccess.rb  
~~~~~~~~
class ClassAccess  
  def m1          # this method is public  
  end  
  protected  
    def m2        # this method is protected  
    end  
  private  
    def m3        # this method is private  
    end  
end  
ca = ClassAccess.new  
ca.m1  
#ca.m2  
#ca.m3  
~~~~~~~~

If you remove the comments of the last two statements in the above program, you will get an access violation runtime error.






