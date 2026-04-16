puts "Criando status de chamados..."

TicketStatus.find_or_create_by!(name: "Aberto") do |s|
  s.is_default = true
  s.is_final = false
end

TicketStatus.find_or_create_by!(name: "Em andamento") do |s|
  s.is_default = false
  s.is_final = false
end

TicketStatus.find_or_create_by!(name: "Aguardando resposta") do |s|
  s.is_default = false
  s.is_final = false
end

TicketStatus.find_or_create_by!(name: "Concluído") do |s|
  s.is_default = false
  s.is_final = true
end



puts "Criando tipos de chamados..."

TicketType.find_or_create_by!(title: "Manutenção") do |t|
  t.sla_hours = 48
end

TicketType.find_or_create_by!(title: "Limpeza") do |t|
  t.sla_hours = 24
end

TicketType.find_or_create_by!(title: "Segurança") do |t|
  t.sla_hours = 12
end

TicketType.find_or_create_by!(title: "Barulho") do |t|
  t.sla_hours = 6
end

TicketType.find_or_create_by!(title: "Outros") do |t|
  t.sla_hours = 72
end



puts "Criando administrador padrão..."

User.find_or_create_by!(email: "admin@condominio.com") do |u|
  u.name = "Administrador"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :admin
end