puts "Criando status de chamados..."

TicketStatus.create!([
  { name: "Aberto", is_default: true, is_final: false },
  { name: "Em andamento", is_default: false, is_final: false },
  { name: "Aguardando resposta", is_default: false, is_final: false },
  { name: "Concluído", is_default: false, is_final: true }
])

puts "Criando tipos de chamados..."

TicketType.create!([
  { title: "Manutenção", sla_hours: 48 },
  { title: "Limpeza", sla_hours: 24 },
  { title: "Segurança", sla_hours: 12 },
  { title: "Barulho", sla_hours: 6 },
  { title: "Outros", sla_hours: 72 }
])

puts "Criando administrador padrão..."

User.create!(
  name: "Administrador",
  email: "admin@condominio.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

puts "Seeds criados com sucesso!"