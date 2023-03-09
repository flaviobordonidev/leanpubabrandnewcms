# <a name="top"></a> Cap active_record-find.01b - Nommi delle colonne delle tabelle

Come vedere i nomi delle colonne di una tabella


## Model.column_names

Si mette il nome del model di cui vogliamo vedere le colonne e poi il suffisso `.column_names`.

```ruby
$ rails c
> User.column_names
> User.columns
```

Esempio:

```ruby
ubuntu@ubuntufla:~/ubuntudream (lng)$rails c
Loading development environment (Rails 7.0.4)
3.1.1 :001 > User.column_names
 => 
["id",                                              
 "username",                                        
 "first_name",                                      
 "last_name",                                       
 "location",                                        
 "bio",                                             
 "phone_number",                                    
 "email",                                           
 "encrypted_password",                              
 "reset_password_token",                            
 "reset_password_sent_at",                          
 "remember_created_at",                             
 "created_at",                                      
 "updated_at",                                      
 "role",
 "language"] 
3.1.1 :002 > User.columns
 => 
[#<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e665d20
  @collation=nil,                     
  @comment=nil,                       
  @default=nil,                       
  @default_function="nextval('users_id_seq'::regclass)",
  @generated="",
  @name="id",
  @null=false,
  @serial=true,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e660668
    @limit=8,
    @precision=nil,
    @scale=nil,
    @sql_type="bigint",
    @type=:integer>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e66ba90
  @collation=nil,
  @comment=nil,
  @default="",
  @default_function=nil,
  @generated="",
  @name="username",
  @null=false,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e66aca8
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="first_name",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e66a3e8
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="last_name",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e669560
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="location",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e668de0
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="bio",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e668700
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="phone_number",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e66fe10
  @collation=nil,
  @comment=nil,
  @default="",
  @default_function=nil,
  @generated="",
  @name="email",
  @null=false,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e66f028
  @collation=nil,
  @comment=nil,
  @default="",
  @default_function=nil,
  @generated="",
  @name="encrypted_password",
  @null=false,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e66e088
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="reset_password_token",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e664510
    @limit=nil,
    @precision=nil,
    @scale=nil,
    @sql_type="character varying",
    @type=:string>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e66cb98
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="reset_password_sent_at",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e66d048
    @limit=nil,
    @precision=6,
    @scale=nil,
    @sql_type="timestamp(6) without time zone",
    @type=:datetime>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e673ec0
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="remember_created_at",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e66d048
    @limit=nil,
    @precision=6,
    @scale=nil,
    @sql_type="timestamp(6) without time zone",
    @type=:datetime>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e677e80
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="created_at",
  @null=false,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e66d048
    @limit=nil,
    @precision=6,
    @scale=nil,
    @sql_type="timestamp(6) without time zone",
    @type=:datetime>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e676f80
  @collation=nil,
  @comment=nil,
  @default=nil,
  @default_function=nil,
  @generated="",
  @name="updated_at",
  @null=false,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e66d048
    @limit=nil,
    @precision=6,
    @scale=nil,
    @sql_type="timestamp(6) without time zone",
    @type=:datetime>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e674ff0
  @collation=nil,
  @comment=nil,
  @default="0",
  @default_function=nil,
  @generated="",
  @name="role",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e675838
    @limit=4,
    @precision=nil,
    @scale=nil,
    @sql_type="integer",
    @type=:integer>>,
 #<ActiveRecord::ConnectionAdapters::PostgreSQL::Column:0x00007fab1e674028
  @collation=nil,
  @comment=nil,
  @default="0",
  @default_function=nil,
  @generated="",
  @name="language",
  @null=true,
  @serial=nil,
  @sql_type_metadata=
   #<ActiveRecord::ConnectionAdapters::SqlTypeMetadata:0x00007fab1e675838
    @limit=4,
    @precision=nil,
    @scale=nil,
    @sql_type="integer",
    @type=:integer>>] 
3.1.1 :003 > 
```

