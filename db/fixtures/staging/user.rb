User.seed(:id,
  { id: 1, email: "lisa@koombea.com", password: "cuddy", role_type: "admin"},
  { id: 2, email: "juan@koombea.com", password: "123123", role_type: "doctor"},
  { id: 3, email: "andres@koombea.com", password: "123123", role_type: "patient"},
)