using Godot;
using System;

public partial class Player : CharacterBody2D
{
    public const float Speed = 200.0f; // Velocidade do personagem

    public override void _PhysicsProcess(double delta)
    {
        Vector2 velocity = Vector2.Zero; // Inicializa a velocidade como zero

        // Obtém a direção do input do jogador
        Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");

        if (direction != Vector2.Zero)
        {
            velocity = direction * Speed; // Aplica a velocidade na direção escolhida
        }

        Velocity = velocity;
        MoveAndSlide(); // Movimenta o personagem com base na velocidade calculada
    }
}
