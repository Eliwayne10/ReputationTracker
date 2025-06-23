;; A simple badge leaderboard system
;; Author: ChatGPT | Project 33

;; =========================
;; CONFIGURATION
;; =========================

;; Set the contract owner (change to your deployer address if needed)
(define-constant contract-owner 'ST000000000000000000002AMW42H)

;; =========================
;; STORAGE
;; =========================

;; Store number of badges per user
(define-map user-badges
  { user: principal }
  { count: uint }
)

;; =========================
;; FUNCTIONS
;; =========================

;; Award a badge to a user (admin only)
(define-public (award-badge (user principal))
  (begin
    ;; Only the contract owner can award badges
    (asserts! (is-eq tx-sender contract-owner) (err "Only contract owner can award badges"))

    ;; Get current badge count (default to 0)
    ;; LSP warning: 'user' is untrusted input, but is only used as a map key (safe)
    (let ((current (default-to u0 (get count (map-get? user-badges {user: user})))))

      ;; 'current' is always a uint due to 'default-to', so this is safe
      (map-set user-badges {user: user} {count: (+ current u1)})

      (ok (+ current u1))
    )
  )
)

;; Get how many badges a user has
(define-read-only (get-user-badges (user principal))
  ;; LSP warning: potentially unchecked data, but 'default-to' ensures a value is always returned (safe)
  (ok (default-to u0 (get count (map-get? user-badges {user: user}))))
)

;; Compare two users and return the one with more badges
(define-read-only (get-leader (user1 principal) (user2 principal))
  ;; LSP warning: potentially unchecked data, but 'default-to' ensures a value is always returned (safe)
  (let (
    (badges1 (default-to u0 (get count (map-get? user-badges {user: user1}))))
    (badges2 (default-to u0 (get count (map-get? user-badges {user: user2}))))
  )
    (if (> badges1 badges2)
        (ok user1)
        (if (> badges2 badges1)
            (ok user2)
            (ok user1) ;; tie, return user1 as default
        )
    )
  )
)
