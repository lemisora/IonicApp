import { Component, OnInit, Input, Output, EventEmitter } from "@angular/core";

@Component({
  selector: "app-post",
  templateUrl: "./post.component.html",
  styleUrls: ["./post.component.scss"],
})
export class PostComponent {
  @Input() mensaje: any;
  @Output() clickPost = new EventEmitter<number>();
  constructor() {}
  ngOnInit() {}

  onClick() {
    this.clickPost.emit(this.mensaje.id);
  }
}
